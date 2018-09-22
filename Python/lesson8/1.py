import boto3

s3 = boto3.resource('s3')
new_bucket_name = 'kdeyko-python-new-123456'
bucket_list = ['kdeyko-python-test1', 'kdeyko-python-test2']

# new_bucket = s3.Bucket(new_bucket_name)
# new_bucket.create(CreateBucketConfiguration={'LocationConstraint': 'us-east-2'})
new_bucket = s3.create_bucket(Bucket=new_bucket_name)


for bucket in bucket_list:
    source_bucket = s3.Bucket(bucket)
    for obj in source_bucket.objects.all():
        copy_source = {
            'Bucket': obj.bucket_name,
            'Key': obj.key
        }
        new_bucket.copy(copy_source, obj.key)

# bucket = s3.Bucket('kdeyko-python-test1')
# for obj in bucket.objects.all():
#     print(obj.key)
# # print(bucket.name)
#
# ec2 = boto3.resource('ec2', 'us-east-2')
# instance = ec2.Instance('i-05a56d3bd96a1df3a')
# instance.stop()
# ec2.create_instances(
#     ImageId='ami-0552e3455b9bc8d50',
#     InstanceType='t2.micro',
#     MinCount=1,
#     MaxCount=1
# )
# for instance in ec2.instances.all():
#     print(instance.instance_id)