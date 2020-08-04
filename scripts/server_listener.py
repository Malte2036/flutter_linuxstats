import asyncio
import websockets
from termcolor import colored

import system_data

async def echo(websocket, path):
    async for message in websocket:
        await handleMessage(message, websocket)

async def handleMessage(message, websocket):
    print(message)
    if(message == "getSystemData()"):
        await sendSystemData(websocket)
    else:
        print(colored("message not valid!", 'red'))

async def sendSystemData(websocket):
    data = system_data.getData()
    await websocket.send(data)
    print(colored("Reply: " + data, 'green'))




print(colored('starting websocket server at ws://localhost:9499...', 'green'))

asyncio.get_event_loop().run_until_complete(
    websockets.serve(echo, '0.0.0.0', 9499))
asyncio.get_event_loop().run_forever()
