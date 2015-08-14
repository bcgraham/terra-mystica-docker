FROM postgres:latest 
RUN apt-get update 
RUN apt-get install -y apache2 libapache2-mod-fcgid
RUN apt-get install perl -y
RUN apt-get install git -y
RUN apt-get install emacs -y
RUN apt-get install make -y
RUN apt-get install texinfo -y
RUN apt-get install curl -y
RUN git clone https://github.com/jsnell/terra-mystica 
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm install File::Slurp 
RUN mkdir /terra-mystica/www-dev
RUN perl /terra-mystica/deploy.pl /terra-mystica/www-dev/  