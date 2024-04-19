from datetime import datetime, timedelta
import random
import string

def getDate(days):
    days = int(days)
    if days == 0:
        return datetime.now().date()
    else:
        future_time = datetime.now() + timedelta(days=days)
        return future_time.date()
    
def getName(length):
    length = int(length)
    return ''.join(random.choices(string.ascii_letters, k=length))

def getm(randomtext):
    str1 = 'Done ! Computer '
    str2 = ' has been created'
    concatenated_string = str1 + randomtext + str2
    return concatenated_string
