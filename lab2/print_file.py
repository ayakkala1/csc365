import sys
import datetime
from dateutil.parser import parse
file_object = open(sys.argv[1])
lines = file_object.readlines()
dash = sys.argv[1].find("/") + 1
lines = [i for i in lines if i != "\n"]
for line in lines:
    if line == lines[0]:
        print("INSERT INTO " + sys.argv[1][dash:-4] + " ",end = '') 
        print("(" + line[:-1] + ")\nVALUES")
    else:
        end = False
        if line == lines[-1]:
            end = True
        if sys.argv[1][dash:-4] == "receipts":
            split_line = line.split(",")
            parse_time = str(parse(split_line[1]))
            space = parse_time.find(" ")
            parse_time = "'" + parse_time[:space] + "'"
            split_line[1] = parse_time
            line = ",".join(split_line)
        elif sys.argv[1][dash:-4] == "reviews":
            split_line = line.split(",")
            split_line[1] = split_line[1].replace("\n",'')
            parse_time = str(parse(split_line[1]))
            space = parse_time.find(" ")
            parse_time = "'" + parse_time[:space] + "'"
            split_line[1] = parse_time
            line = ",".join(split_line)
        elif sys.argv[1][dash:-4] == "Reservations":
            split_line = line.split(",")
            for i in range(2,4):
                parse_time = str(parse(split_line[i]))
                space = parse_time.find(" ")
                parse_time = "'" + parse_time[:space] + "'"
                split_line[i] = parse_time
            line = ",".join(split_line)
        if end:
            print("(" + line[:-1] + ");")
        else:
            print("(" + line[:-1] + "),")
file_object.close()
