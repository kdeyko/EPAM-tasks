from collections import Counter
import requests
from requests.exceptions import *
import argparse
from datetime import datetime
import getpass
from html.parser import HTMLParser
import boto3


def create_parser():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('-u', '--url', required=True)
    arg_parser.add_argument('-l', '--log-file')
    arg_parser.add_argument('-b', '--bucket-name')
    arg_parser.add_argument('--access-key')
    arg_parser.add_argument('--secret-key')
    return arg_parser


def count_tags(url, log=None, bucket_name=None, access_key=None, secret_key=None):

    result = Counter()

    class GetTags(HTMLParser):
        def handle_starttag(self, tag, attrs):
            result[tag] += 1

    parser = GetTags()

    try:
        page = requests.get(url).text
        parser.feed(page)
    except (ConnectionError, MissingSchema, InvalidURL):
        print("URL not found or invalid!\n"
              "Don't forget about http:// or https:// at the beginning of URL.")
        exit()

    result_str = f'{sum(result.values())} {str(result)[8:-1]}'

    if log:
        with open(log, 'a') as f:
            timestamp = datetime.strftime(datetime.now(), "%Y.%m.%d %H:%M")
            log_string = f'{timestamp}\t{url}\t{result_str}\n'
            f.write(log_string)

    if bucket_name:
        if not log:
            print('Please specify the log file name using -l parameter')
            exit()
        else:
            timestamp = datetime.strftime(datetime.now(), "%Y-%m-%d-%H-%M-%S")
            bucket_name = bucket_name + '-' + timestamp

            if not access_key:
                access_key = getpass.getpass(prompt='Please enter your aws_access_key_id: ')
            if not secret_key:
                secret_key = getpass.getpass(prompt='Please enter your aws_secret_access_key: ')

            session = boto3.Session(
                aws_access_key_id=access_key,
                aws_secret_access_key=secret_key
            )

            s3 = session.resource('s3',region_name='us-east-1')
            s3.create_bucket(Bucket=bucket_name)
            s3.Bucket(bucket_name).upload_file(log, log)

    print(result_str)


if __name__ == '__main__':
    namespace = create_parser().parse_args()

    count_tags(namespace.url,
               namespace.log_file,
               namespace.bucket_name,
               namespace.access_key,
               namespace.secret_key)
