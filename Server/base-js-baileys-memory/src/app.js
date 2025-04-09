import { join } from "path";
import {
  createBot,
  createProvider,
  createFlow,
  addKeyword,
  utils,
} from "@builderbot/bot";
import { MemoryDB as Database } from "@builderbot/bot";
import { BaileysProvider as Provider } from "@builderbot/provider-baileys";
import axios from "axios";
import { json } from "stream/consumers";

const PORT = process.env.PORT ?? 3008;
const fullSamplesFlow = addKeyword(["samples", utils.setEvent("SAMPLES")])
  .addAnswer(`💪 I'll send you a lot files...`)
  .addAnswer(`Send image from Local`, {
    media: join(process.cwd(), "assets", "sample.png"),
  })
  .addAnswer(`Send video from URL`, {
    media:
      "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYTJ0ZGdjd2syeXAwMjQ4aWdkcW04OWlqcXI3Ynh1ODkwZ25zZWZ1dCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LCohAb657pSdHv0Q5h/giphy.mp4",
  })
  .addAnswer(`Send audio from URL`, {
    media: "https://cdn.freesound.org/previews/728/728142_11861866-lq.mp3",
  })
  .addAnswer(`Send file from URL`, {
    media:
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
  });

const registerFlow = addKeyword(utils.setEvent("REGISTER_FLOW"))
  .addAnswer(
    `What is your name?`,
    { capture: true },
    async (ctx, { state }) => {
      await state.update({ name: ctx.body });
    }
  )
  .addAnswer("What is your age?", { capture: true }, async (ctx, { state }) => {
    await state.update({ age: ctx.body });
  })
  .addAction(
    async (_, { flowDynamic, state }) => {
      await flowDynamic(
        `${state.get(
          "name"
        )}, thanks for your information!: Your age: ${state.get("age")}`
      );
    },
    [fullSamplesFlow]
  );

const discordFlow = addKeyword("numPrueba").addAnswer(
  [
    "Porfavor espera un momento mientras busco tu información... ⏳",
    "\n ⌛⏳⌛⏳⌛⏳ ",
  ].join("\n"),
  { delay: 800 },
  async ({ flowDynamic }) => {
    let data = "";

    await axios.get("http://localhost:5000/workers").then((response) => {
      console.log(response.data);
      data = response.data;
    });
    if (data != "") {
      await flowDynamic(`Tus datos son los siguientes: ${data}`);
    } else {
      await flowDynamic(`No se encontraron datos para el numero de servicio`);
    }
  }
);
const welcomeFlow = addKeyword(["hi", "hello", "hola"])
  .addAnswer(`🙌 Hola Gracias por comunicarte con ProCollision 🤖🚗🛠️🔧*`)
  .addAnswer(
    [
      "Si desea saber mas sobre el estado de su vehiculo, por favor escriba *Su numero de servicio*",
      "👉 *numPrueba* para una prueba del Bot 🤖🚗🛠️🔧",
    ].join("\n"),
    { delay: 800, capture: true },
    async (ctx, { state }) => {
      await state.update({ numOrder: ctx.body });
    }
  )
  .addAction(async (_, { flowDynamic, state }) => {
    let data = "";

    await axios
      .get("http://localhost:5000/workers")
      .then((response) => {
        console.log(response.data);
        data = response.data;
      })
      .finally(() => {
        console.log("finally");
      });
    if (data != "") {
      await flowDynamic([
        `${state.get(
          "numOrder"
        )}, gracias por tu mensaje, ahora buscaremos la información de la orden de servicio`,
        `tu informacion es la siguiente:${JSON.stringify(data[0])}`,
      ]);
    }
  })
  .addAnswer("respuesta tras data");

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
      return res.end(JSON.stringify({ status: "ok"}));
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
