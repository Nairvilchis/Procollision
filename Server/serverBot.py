from flask import Flask, request
from twilio.twiml.messaging_response import MessagingResponse

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def whatsapp_webhook():
    incoming_msg = request.values.get('Body', '').lower()
    response = MessagingResponse()
    msg = response.message()

    if 'hola' in incoming_msg:
        msg.body('¡Hola! ¿En qué puedo ayudarte?')
    elif 'adiós' in incoming_msg:
        msg.body('¡Hasta luego!')
    else:
        msg.body('Lo siento, no entiendo tu mensaje.')

    return str(response)

if __name__ == '__main__':
    app.run(debug=True)