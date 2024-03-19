.PHONY: setup consume produce clean

SHELL=/bin/bash

setup:
	# Start the kafka cluster and other required services
	docker compose up -d
	# Extract the example data
	bin/extract-example-json.sh
	# Create the required topic
	bin/rpk.sh topic create web_requests

consume:
	bin/consume-example-json.sh  
	# You can also pass an argument to override the allowed_latency (defaults to 60)
	# bin/consume-example-json.sh 15

produce:
	cat tests/json/web_requests-100K.json | bin/rpk.sh topic produce web_requests

clean:
	bin/clean-example-data.sh
