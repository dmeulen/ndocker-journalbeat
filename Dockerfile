FROM mheese/journalbeat

COPY journalbeat.yml ./
COPY journalbeat.template.json ./

CMD ["./journalbeat", "-e", "-c", "journalbeat.yml"]
