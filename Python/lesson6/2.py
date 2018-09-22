import re

class ParserAccessLog:
    def __init__(self, file_name):
        self.filename = file_name

    def get_spam_ips(self, count):
        pattern = re.compile('^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')
        with open(self.filename) as f:
            ips = {}
            for line in f:
                ip = pattern.findall(line)
                if ip:
                    if not ips.get(ip[0]):
                        ips[ip[0]] = 0
                    else:
                        ips[ip[0]] += 1




filename = 'access.log'
prs = ParserAccessLog(filename)
prs.get_spam_ips(1)