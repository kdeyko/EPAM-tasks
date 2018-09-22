import csv

class Parser1000:
    def __init__(self, file_name):
        self.filename = file_name

    def change_delimiter(self, delimiter, new_file_name):
        with open(self.filename, 'r') as r_file:
            with open(new_file_name, 'w') as w_file:
                orig_file = csv.reader(r_file)
                new_file = csv.writer(w_file, delimiter=delimiter)
                new_file.writerows(orig_file)
        return print(f"file {new_file_name} created!")

    def get_total_country_profit(self, country):
        with open(self.filename, 'r') as r_file:
            orig_file = csv.DictReader(r_file)
            profit = 0
            for line in orig_file:
                if line['Country'] == country:
                    profit += float(line['Total Profit'])
            return print(profit)

    def get_lucky_countries(self, category, number):
        with open(self.filename, 'r') as r_file:
            orig_file = csv.DictReader(r_file)
            for line in orig_file:
                if line['Item Type'] == category:
                    if int(line['Units Sold']) > number:
                        print(line['Country'])





filename = '1000 Sales Records.csv'
prs = Parser1000(filename)

# prs.change_delimiter('!', 'test1.csv')

# prs.get_total_country_profit('Libya')

# prs.get_lucky_countries('Fruits', 5000)