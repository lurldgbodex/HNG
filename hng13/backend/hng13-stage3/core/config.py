from transformers import pipeline

MODEL_NAME = 'google/flan-t5-large'

generator = pipeline('text2text-generation', model=MODEL_NAME)