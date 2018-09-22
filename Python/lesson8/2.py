import boto3

def change_status(region, status, action):
    ec2 = boto3.resource('ec2', region_name=region)

    for instance in ec2.instances.all():
        if instance.state['Name'] == status:
            method = getattr(instance, action)
            method()

change_status('us-east-2', 'stopping', 'terminate')
