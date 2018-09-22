from time import sleep


def delay(fn):
    def wrapper():
        sleep(2)
        fn()
    return wrapper


@delay
def mega_print():
    print('fucking decorators...')


mega_print()
