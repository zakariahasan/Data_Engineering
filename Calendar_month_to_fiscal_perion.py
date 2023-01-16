'''
Here is a Python code that maps calendar months to fiscal periods starting with June, where the fiscal period has 12 months:
'''

def map_month_to_fiscal_period(month):
    if month>=6:
        return month-5
    else:
        return month+7

# Example usage:
print(map_month_to_fiscal_period(6)) # Output: 1
print(map_month_to_fiscal_period(11)) # Output: 6
print(map_month_to_fiscal_period(12)) # Output: 7
print(map_month_to_fiscal_period(1)) # Output: 8




'''
This code defines a function called map_month_to_fiscal_period that takes in an integer representing a calendar month (1-12) and 
returns the corresponding fiscal period.
It uses a simple if-else statement. If the month is greater or equal than 6, it subtracts 5 from the month and returns the result. 
If not, it adds 7 to the month and returns the result.

This way, June is the first month of the fiscal period, July is the second and so on until May which is the 12th month of the fiscal period.
'''
