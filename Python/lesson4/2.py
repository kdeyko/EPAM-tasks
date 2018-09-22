def bold(fn):
    def wrapped(*args, **kwargs):
        return '<b>' + fn(*args, **kwargs) + '</b>'
    return wrapped


def italic(fn):
    def wrapped(*args, **kwargs):
        return '<i>' + fn(*args, **kwargs) + '</i>'
    return wrapped


def underline(fn):
    def wrapped(*args, **kwargs):
        return '<u>' + fn(*args, **kwargs) + '</u>'
    return wrapped


@bold
@italic
def print_this(string):
    return str(string)


print(print_this('hello'))
