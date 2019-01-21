#H14_nathaniel
#Nathaniel Wieck
#CSC 110
#15 JUN 2018

#extra credit: practicing 2-D list, nested loop, file input, and modular design with functions

def main():
    """
    MAIN FUNCTION: Introduces program, gets input and calls "check_loshu" function. Also reports any and all exceptions with a general report.
    """
    print("Hello user! This program will open a file as specified in the directions for HW14,\
        \ndisplay the contents, and determine whether or not the contents make a Lo Shu Magic Square.\n")
    try:
        filename = input("To start, enter the complete file name, including the extension (ie: test.txt): \n")
        check_loshu(filename)
    except:
        print("Oops the program has caught an error! Please double-check and try again.")

def check_loshu(filename):
    """
    FUNCTION: Calls "str_2d_list", "num_2d_list", "display_2d_list" and "check_sum" functions.
    Also displays if input file is a Lo Shu Magic Square or not.
    PARAMETER: "filename" referring to input file from "main" function.
    """
    lo_shu = True
    str_2d_list = convert_to_string_list(filename)
    num_2d_list = convert_to_num(str_2d_list)
    display_2d_list(num_2d_list)
    check_sum = check_sums(num_2d_list)
    if not check_sum:
        print("\nNo, the above {} x {} matrix is not a Lo Shu Magic Square\
        \nbecause the sum of every single individual row and column are not equal.".format(len(num_2d_list), len(num_2d_list)))
    if check_sum:
        print("\nYes, the above {} x {} matrix is a verified Lo Shu Magic Square!".format(len(num_2d_list), len(num_2d_list)))

def convert_to_string_list(filename):
    """
    FUNCTION: Opens the input file "filename", reads then converts contents to a 2d list by splitting, stripping and appending.
    PARAMETER: "filename" referring to input file from "main" function.
    RETURN: "str_2D_list" which is a 2d list of the file's contents.
    """
    file_contents = open(filename, 'r')
    eof = False
    str_2d_list = []
    while not eof:
        line = file_contents.readline()
        if line == "":
            eof = True
        else:
            line_list = line.split(",")
            line_list[-1] = line_list[-1].rstrip('\n')
            str_2d_list.append(line_list)
    file_contents.close()
    return str_2d_list

def convert_to_num(str_list):
    """
    FUNCTION: Converts the 2d list elements from strings to numbers.
    PARAMETER: "str_list" referring to "str_2D_list" from "main" function.
    RETURN: "str_list" to "num_2D_list" in "main" function.
    """
    for row in range(len(str_list)):
        for col in range(len(str_list)):
            str_list[row][col] = int(str_list[row][col])
    return str_list

def display_2d_list(num_2d_list):
    """
    FUNCTION: Displays the 2d list.
    PARAMETER: "num_2d_list" referring to the same from "main" function.
    """
    print()
    for row in num_2d_list:
        print(row)

def check_sums(num_2d_list):
    """
    FUNCTION: Checks the sums of the rows and columns to determine if it is a Low Shu Magic Square or not.
    PARAMETER: "num_2d_list" referring to the same from the "main" function.
    RETURN: "True" or "False" depending if each the sum of each row and column are equal or not.
    """
    lo_shu_sum = sum(num_2d_list[0])
    for i in range(len(num_2d_list)):
        sum_row_i = sum(num_2d_list[i][:])
        if sum_row_i != lo_shu_sum:
            return False
    for j in range(len(num_2d_list)):
        sum_col_j = sum(num_2d_list[:][j])
        if sum_col_j != lo_shu_sum:
            return False
    return True

#calls the main function
if __name__=="__main__":
    main()

