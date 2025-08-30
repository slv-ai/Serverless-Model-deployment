import pickle

with open('model.bin','rb') as f_in:
    pipeline = pickle.load(f_in)

def predict(customer):
    result=pipeline.predict_proba(customer)[0,1]
    return float(result)

def lambda_handler(event,context):
    print("parameters:",event)
    customer=event['customer']
    prob= predict(customer)
    return {
        'churn_probability': prob,
        "churn": prob>=0.5
    }