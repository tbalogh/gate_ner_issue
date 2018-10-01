# gate_ner_issue

To reproduce the issue follow the steps:

1. docker build -t gate-server .
2. docker run -it -m 8G -p 8000:8000 gate-server

3. chmod +x ./emw.sh

4. cat working_example.txt | ./emw.sh -t ner |  grep -B 5 -A 1 "NER"
5. cat not_working_example.txt | ./emw.sh -t ner | grep -B 5 -A 1 "NER"