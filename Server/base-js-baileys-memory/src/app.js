import { join } from "path";
import {
  createBot,
  createProvider,
  createFlow,
  addKeyword,
  utils,
  EVENTS,
} from "@builderbot/bot";
import { MemoryDB as Database } from "@builderbot/bot";
import { BaileysProvider as Provider } from "@builderbot/provider-baileys";
import axios from "axios";
import { json } from "stream/consumers";

const PORT = process.env.PORT ?? 3008;

const welcomeFlow = addKeyword(["hi", "hello", "hola", EVENTS.WELCOME])
  .addAnswer(`🙌 Hola Gracias por comunicarte con ProCollision 🤖🚗🛠️🔧*`)
  .addAnswer(
    "Si desea saber mas sobre el estado de su vehiculo, por favor escriba *Su numero de servicio*"
  )
  .addAnswer(
    [
      "👉 *numOrder* para una prueba del Bot 🤖🚗🛠️🔧",
      "👉 *numOrder1* para una prueba del Bot 🤖🚗🛠️🔧",
      "👉 *numOrder2* para una prueba del Bot 🤖🚗🛠️🔧",
    ].join("\n"),
    { delay: 800 }
  )
  .addAction(
    { capture: true },
    async (ctx, { fallBack, flowDynamic, state }) => {
      await state.update({ numOrder: ctx.body });
      await state.update({ firsTime: true });
      let orderData = null;
      let Clientdata;

      try {
        const responseOrder = await axios.get(
          "http://localhost:5000/order/" + state.get("numOrder")
        );

        const responseCliente = await axios.get(
          "http://localhost:5000/client/" + responseOrder.data.client_id
        );
        const responseMake = await axios.get(
          "http://localhost:5000/make/" + responseOrder.data.make
        );
        const responseModel = await axios.get(
          "http://localhost:5000/model/" + responseOrder.data.model
        );
        Clientdata = responseCliente.data; // Accede a los datos de la respuesta

        orderData = responseOrder.data; // Accede a los datos de la respuesta

        // Aquí puedes procesar los datos según tus necesidades
        if (orderData) {
          await flowDynamic(
            `*Hola ${Clientdata.name}* \n\n*Su vehiculo es un ${responseMake.data.Nombre} ${responseModel.data.model}* \n\n*El estado de su vehiculo es: ${orderData.status}*`
          );
        }
      } catch (error) {
        if (error.status === 404) {
          return fallBack(
            `No se encontró información para el número de orden proporcionado "${state.get(
              "numOrder"
            )}",favor de verificar su numero de orden. Ingreselo de nuevo `
          );
        }
        console.error("Error al obtener los datos del pedido:", error);
        await flowDynamic(
          "Hubo un error al obtener la información del pedido. Por favor, inténtelo más tarde."
        );
      }
    }
  );

const main = async () => {
  const adapterFlow = createFlow([welcomeFlow]);

  const adapterProvider = createProvider(Provider);
  const adapterDB = new Database();

  const { handleCtx, httpServer } = await createBot({
    flow: adapterFlow,
    provider: adapterProvider,
    database: adapterDB,
  });

  adapterProvider.server.post(
    "/v1/messages",
    handleCtx(async (bot, req, res) => {
      console.log("message", req.body);
      const { number, message, urlMedia } = req.body;
      await bot.sendMessage(number, message, { media: urlMedia ?? null });
      res.writeHead(201, { "Content-Type": "application/json" });
      return res.end(JSON.stringify({ status: "ok" }));
    })
  );

  adapterProvider.server.post(
    "/v1/register",
    handleCtx(async (bot, req, res) => {
      const { number, name } = req.body;
      await bot.dispatch("REGISTER_FLOW", { from: number, name });
      return res.end("trigger");
    })
  );

  adapterProvider.server.post(
    "/v1/samples",
    handleCtx(async (bot, req, res) => {
      const { number, name } = req.body;
      await bot.dispatch("SAMPLES", { from: number, name });
      return res.status(200).end("trigger");
    })
  );

  adapterProvider.server.post(
    "/v1/blacklist",
    handleCtx(async (bot, req, res) => {
      const { number, intent } = req.body;
      if (intent === "remove") bot.blacklist.remove(number);
      if (intent === "add") bot.blacklist.add(number);

      res.writeHead(200, { "Content-Type": "application/json" });
      return res.end(JSON.stringify({ status: "ok", number, intent }));
    })
  );

  httpServer(+PORT);
};

main();
