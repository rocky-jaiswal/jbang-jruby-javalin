FROM amazoncorretto:21

RUN mkdir -p /opt/app

WORKDIR /opt/

RUN yum update -y
RUN yum install -y wget unzip

RUN wget https://repo1.maven.org/maven2/org/jruby/jruby-dist/9.4.8.0/jruby-dist-9.4.8.0-bin.zip
RUN wget https://github.com/jbangdev/jbang/releases/download/v0.122.0/jbang-0.122.0.zip

RUN unzip jruby-dist-9.4.8.0-bin.zip
RUN unzip jbang-0.122.0.zip

RUN ls -l

RUN mv /opt/jruby-9.4.8.0 /opt/jruby
RUN mv /opt/jbang-0.122.0 /opt/jbang
RUN ls -l /opt/jbang

ENV PATH="/opt/jruby/bin:/opt/jbang/bin:$PATH"

RUN gem install jwt

WORKDIR /opt/app/

COPY . .

EXPOSE 7070

CMD ["jbang", "RunJRuby.java", "javalin.rb"]
