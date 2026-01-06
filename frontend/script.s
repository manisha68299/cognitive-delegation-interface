let contextText = "";

function analyze() {
  const input = document.getElementById("input").value.trim();

  if (input === "") {
    alert("Please paste ingredient list first.");
    return;
  }

  contextText = input;
  document.getElementById("decisionBox").classList.remove("hidden");
  document.getElementById("result").innerText = "";
}

async function delegate(consent) {
  document.getElementById("result").innerText = "AI is reasoning...\n";

  try {
    const response = await fetch("https://YOUR-BACKEND-URL/delegate", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        text: contextText,
        consent: consent
      })
    });

    const data = await response.json();
    document.getElementById("result").innerText = data.explanation;

  } catch (error) {
    document.getElementById("result").innerText =
      "Error: Unable to reach decision system.";
  }
}
