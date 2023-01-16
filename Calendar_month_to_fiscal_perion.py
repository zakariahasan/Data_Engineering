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
