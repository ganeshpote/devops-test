FROM cartahub/devops

WORKDIR /carta/devops

ENV PATH="/carta/devops:${PATH}"

COPY . .

CMD ["carta-devops", "serve"]
