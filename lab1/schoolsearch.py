import pandas as pd
from numpy import dtype
import math
import numpy as np
def main():
    try:
        list_df = pd.read_csv("https://s3-us-west-1.amazonaws.com/csc365-spring2019/list.txt",
           header = None,
           names = ["StLastName",
                    "StFirstName",
                    "Grade",
                    "Classroom",                    
                    "Bus",
                    "GPA"])

        teachers_df = pd.read_csv("https://s3-us-west-1.amazonaws.com/csc365-spring2019/teachers.txt",
           header = None,
           names = ["TLastName",
                    "TFirstName",
                    "Classroom"])
        df = list_df.merge(teachers_df)
    except:
        print("File not Found")
    if (list(df.dtypes.values) != ([dtype('O'),
                                 dtype('O'),
                                 dtype('int64'),
                                 dtype('int64'),
                                 dtype('int64'),
                                 dtype('float64'),
                                 dtype('O'),
                                 dtype('O')])):
        print("Format is incorrect")
        return
    print("Instruction Prompt: \n"
           "Commands: \n"
           "- S[tudent]: <lastname> [B[us]] \n"
           "- T[eacher]: <lastname> \n"
           "- G[rade]: <number> [H[igh]]|L[ow]|S[tudent]|T[eacher]] \n"
           "- C[lassroom]: <number> [S[tudent]|T[eacher]] \n"
           "- A[verage]: <number> \n"
           "- E[nrollment] \n"
           "- I[nfo] \n"
           "- Q[uit] \n"
           "- P[ivot]: <column> \n"
         "Note: The text in arguments is optional while the rest is not. \n"
         "Note: Pivot will always aggregate GPA by the column specified \n"
         "      and return the aggregated variance and mean. \n")
    command = [[" "]]
    while command[0][0] != "Q":
        commands = input("Type in one of these commands! \n \n").upper()
        if ":" in commands:
            command = commands.split(":")
            arguments = command[1].split(" ")
            arguments = [i for i in arguments if i != ""]
        else:
            command = [commands," "]
            arguments = []
        if command[0][0] == "S":
            if len(arguments) == 0:
                print("Arguments not given")
            elif (len(arguments) == 2) and (arguments[1][0].upper() == "B"):
                lastname_query(df, arguments[0], True)
            else:
                lastname_query(df, arguments[0], False)
        elif command[0][0] == "T":
            if len(arguments) == 0:
                print("Arguments not given")
            else:
                teacher_query(df, arguments[0])
        elif command[0][0] == "B":
            if len(arguments) == 0:
                print("Arguments not given")
            else:
                bus_query(df, arguments[0])
        elif command[0][0] == "G":
            if len(arguments) == 0:
                print("Arguments not given")
            elif len(arguments) == 2:
                if arguments[1][0] == "H":
                    hi_lo_query(df, arguments[0], lo = False)
                elif arguments[1][0] == "L":
                    hi_lo_query(df, arguments[0], lo = True)
                elif arguments[1][0] == "T":
                    grade_query(df, arguments[0], find_teach = True)
            else:
                grade_query(df, arguments[0])
        elif command[0][0] == "P":
            if len(arguments) == 0:
                print("Arguments not given")
            else:
                pivot_query(df,arguments[0])
        elif command[0][0] == "A":
            if len(arguments) == 0:
                print("Arguments not given")
            else:
                avg_query(df, arguments[0])
        elif command[0][0] == "I":
            info_query(df)
        elif command[0][0] == "E":
            enrollment_query(df)
        elif command[0][0] == "C":
            if arguments[1][0] == "S":
                classroom_query(df, arguments[0])
            elif arguments[1][0] == "T":
                classroom_query(df, arguments[0], True)

def enrollment_query(df):
    for i in list(zip(df["Classroom"].value_counts().sort_index().index,
                      df["Classroom"].value_counts().sort_index().values)):
        print(i[0],i[1])

def info_query(df):
    for i in range(7):
        num_students = len(df[df["Grade"] == i])
        print("{0}: {1}".format(i,num_students))

def hi_lo_query(df, grade, lo = False):
    try:
        grade = int(grade)
    except:
        print("")
        return
    if lo:
        want_student = df[df["Grade"] == grade]["GPA"] .idxmin()
    else:
        want_student = df[df["Grade"] == grade]["GPA"] .idxmax()
    return print(df.iloc[want_student][["StLastName",
                                "StFirstName",
                                "GPA",
                                "TLastName",
                                "TFirstName",
                                "Bus"]].values)

def avg_query(df, grade):
    try:
        grade = int(grade)
    except:
        print("")
        return
    val = df[df["Grade"] == grade]["GPA"].mean()
    if not math.isnan(val):
        print(val)

def grade_query(df, grade, find_teach = False):
    try:
        grade = int(grade)
    except:
        print("")
        return
    if find_teach:
        teachers = (list(df[df["Grade"] == grade]
                         [["TLastName","TFirstName"]].values))
        print(teachers)
    else:
        students = (list(df[df["Grade"] == grade]
                         [["StLastName","StFirstName"]].values))
        for student in students:
            print(student[0],student[1])

def classroom_query(df, classroom_num, find_teach = False):
    try:
        classroom_num = int(classroom_num)
    except:
        print("")
        return
    if find_teach:
        print(df[df["Classroom"] == classroom_num][["TLastName","TFirstName"]].drop_duplicates().values)
    else:
        print(df[df["Classroom"] == classroom_num][["StLastName","StFirstName"]].values)

def bus_query(df, bus_route):
    try:
        bus_route = int(bus_route)
    except:
        print("")
        return
    students = (list(df[df["Bus"] == bus_route]
                     [["StLastName","StFirstName","Grade"]].values))
    for student in students:
        print(student[0],student[1],student[2])  

def teacher_query(df, teacher):
    if type(teacher) != str:
        print("")
        return
    students = (list(df[df["TLastName"] == teacher]
                     [["StLastName","StFirstName"]].values))
    for student in students:
        print(student[0],student[1])

def lastname_query(df, lastname, bus = False):
    if type(lastname) != str:
        print("")
        return
    if bus:
        filt_df = df[df["StLastName"] == lastname][["Bus"]]
        for row in filt_df.values:
            print(row)
    else:    
        filt_df = df[df["StLastName"] == lastname][["StLastName",
                                                "Grade",
                                                "Classroom",
                                                "TLastName",
                                                "TFirstName"]]
        for row in filt_df.values:
            print(row)

def pivot_query(df, group):
    df_1 = df.copy()
    df_1.columns = [x.upper() for x in df_1.columns]
    if group == "GPA":
        print("Can not aggregate GPA by GPA")
    if group != "GPA" and group in df_1.columns:
        print(df_1.pivot_table(index = group,
                            columns = None,
                            values = "GPA",
                            aggfunc = [np.var,np.mean]))

if __name__ == '__main__':
    main()   
