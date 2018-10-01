FROM picoded/ubuntu-openjdk-8-jdk

WORKDIR /opt/nlp

# Install ubuntu programs

RUN sudo apt-get -y update && \
         apt-get -y install wget curl git g++ make unzip python3 python3-pip vim

# Download and install GATE 8.2

RUN wget https://sourceforge.net/projects/gate/files/gate/8.2/gate-8.2-build5482-BIN.zip
RUN unzip gate-8.2-build5482-BIN.zip && \
    rm gate-8.2-build5482-BIN.zip
ENV PATH $PATH:/opt/nlp
ENV GATE_HOME /opt/nlp/gate-8.2-build5482-BIN

# Download and install HUNLP-Gate plugin

RUN git clone https://github.com/dlt-rilmta/hunlp-GATE.git hunlp-gate
RUN cd hunlp-gate && /bin/bash ./complete.sh

RUN cd /opt/nlp/hunlp-gate/Lang_Hungarian/resources/huntag3 && chmod +x setup_linux.sh && ./setup_linux.sh
RUN pip3 install numpy scipy

# Replace the localhost so it can be reached outside of the container

EXPOSE 8000
RUN sed -i -- 's/localhost/0\.0\.0\.0/g' hunlp-gate/gate-server.props

# Start gate server

CMD cd /opt/nlp/hunlp-gate && ./gate-server.sh
