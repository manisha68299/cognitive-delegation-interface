from fastapi import FastAPI
from pydantic import BaseModel
from logic import delegated_decision

app = FastAPI()

class Request(BaseModel):
    text: str
    consent: bool

@app.post("/delegate")
def delegate(req: Request):

    if not req.text.strip():
        return {"explanation": "No ingredient information provided."}

    if not req.consent:
        return {
            "explanation": (
                "Delegated Cognition OFF.\n\n"
                "I analyzed the ingredient list but did not take responsibility.\n"
                "Final decision remains with you."
            )
        }

    result = delegated_decision(req.text)

    explanation = (
        f"Decision Taken: {result['decision']}\n\n"
        f"Reasoning:\n{result['reasoning']}\n\n"
        f"Uncertainty Level: {result['uncertainty']}"
    )

    return {"explanation": explanation}
