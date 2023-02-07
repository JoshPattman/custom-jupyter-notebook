FROM tensorflow/tensorflow:latest-gpu-jupyter

RUN apt-get install -y swig
RUN apt-get install nano

# enable colors (not sure why they are disabled tbh)
RUN sed -i 's/echo -e "\\e\[m"/#echo -e "\\e\[m"/g' /etc/bash.bashrc
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' $HOME/.bashrc

RUN python -m pip install scipy
RUN python -m pip install sklearn
RUN python -m pip install pandas
RUN python -m pip install flask

#RUN python -m pip install gym
#RUN python -m pip install gym[box2d]
#RUN python -m pip install pygame

RUN python -m pip install jupyterthemes
RUN jt -t oceans16 -cellw 90%

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ENV PASS=password

CMD bash -c "jupyter-notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password='$PASSHASH'"
