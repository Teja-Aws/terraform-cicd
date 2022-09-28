#setup the apache
FROM ec2-image--ami   base-image

#FROM amazon-linux
RUN yum install httpd -y
RUN systemctl enable httpd
RUN systemctl start httpd
RUN aws s3 cp s3://bucket/file.zip 
RUN unzip file.zip
RUN cp -r */var/wwww/html/
CMD ['systemctl start httpd']
ENTRYPOINT['systemctl start httpd']
