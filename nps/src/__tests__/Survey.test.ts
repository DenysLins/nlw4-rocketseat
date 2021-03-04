import request from "supertest";
import { app } from "../app";
import createConnection from "../database";

const prefix = "/api";

describe("Surveys", () => {
  beforeAll(async () => {
    const connection = await createConnection();
    await connection.runMigrations();
  });

  it("Create a valid new survey", async () => {
    const response = await request(app).post(`${prefix}/surveys`).send({
      title: "Queremos ouvir sua opinião",
      description: "De 0 a 10, quanto você recomendaria a Rocketseat",
    });

    expect(response.status).toBe(201);
  });

  it("Get all the surveys", async () => {
    const response = await request(app).get(`${prefix}/surveys`);
    expect(response.status).toBe(200);
  });
});
