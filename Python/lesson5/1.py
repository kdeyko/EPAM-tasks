class Employee:
    def __init__(self, name, surname, salary):
        self.name = name
        self.surname = surname
        self.salary = salary

        self.email = f"{self.name}_{self.surname}@company.com"

    @property
    def fullname(self):
        return f"{self.name} {self.surname}"

    @fullname.setter
    def fullname(self, value):
        self.name, self.surname = value.split()


class DevOps(Employee):
    def __init__(self, name, surname, salary, skills):
        super().__init__(name, surname, salary)
        self.skills = skills

    @classmethod
    def from_string(cls, string):
        name, surname, salary, skills = string.split(';')
        skills = skills.replace('[', '').replace(']', '').replace(' ', '').replace('\'', '').split(',')
        return cls(name, surname, salary, skills)

    def add_skill(self, value):
        self.skills.append(value)

    def remove_skill(self, value):
        self.skills.remove(value)


class Manager(Employee):
    def __init__(self, name, surname, salary, staff):
        super().__init__(name, surname, salary)
        self.staff = staff

    def add_staff(self, value):
        self.staff.append(value)

    def remove_staff(self, value):
        self.staff.remove(value)


dev1 = DevOps('John', 'Doe', 50, ['aws', 'bash', 'python'])
man1 = Manager('Mister', 'Boss', 200, [dev1])

dev2_str = "Arnold;Schwarzenegger;100;['linux', 'chef','ansible']"
dev2 = DevOps.from_string(dev2_str)
