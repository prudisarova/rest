import { Logtail } from "@logtail/node";

export const logger = new Logtail(process.env.LOGTAIL_TOKEN, {
  endpoint: "https://s1518531.us-east-9.betterstackdata.com",
});
