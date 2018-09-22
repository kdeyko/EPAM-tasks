def my_exception(fn):
    def wrapped(*args, **kwargs):
        try:
            return fn(*args, **kwargs)
        except:
            raise ZeroDivisionError
    return wrapped

@my_exception
def print_this(string):
    return str(string + 1)


print(print_this('hello'))
