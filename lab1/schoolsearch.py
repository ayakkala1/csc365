import pandas as pd
from numpy import dtype
import math

def main():
    try:
        df = pd.read_csv("students.txt",header=None, names = ["StLastName",
                                                     "StFirstName",
                                                     "Grade",
                                                     "Classroom",
                                                     "Bus",
                                                     "GPA",
                                                     "TLastName",
                                                     "TFirstName"])
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
           "- G[rade]: <number> [H[igh]]|L[ow]] \n"
           "- A[verage]: <number> \n"
           "- I[nfo] \n"
           "- Q[uit] \n"
         "Note: The text in arguments is optional while the rest is not. \n")
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
            elif len(arguments) == 2:
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
            else:
                grade_query(df, arguments[0])
        elif command[0][0] == "A":
            if len(arguments) == 0:
                print("Arguments not given")
            else:
                avg_query(df, arguments[0])
        elif command[0][0] == "I":
            info_query(df)

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

def grade_query(df, grade):
    try:
        grade = int(grade)
    except:
        print("")
        return
    students = (list(df[df["Grade"] == grade]
                     [["StLastName","StFirstName"]].values))
    for student in students:
        print(student[0],student[1])

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

if __name__ == '__main__':
    main()   
