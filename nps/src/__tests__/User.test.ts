import request from "supertest";
import { app } from "../app";
import createConnection from "../database";

const prefix = "/api";

describe("Users", () => {
  beforeAll(async () => {
    const connection = await createConnection();
    await connection.runMigrations();
  });

  it("Create a valid new user", async () => {
    const response = await request(app).post(`${prefix}/users`).send({
      name: "User Example",
      email: "user@example.com",
    });

    expect(response.status).toBe(201);
  });

  it("Not create a user with duplicated name and email", async () => {
    const response = await request(app).post(`${prefix}/users`).send({
      name: "User Example",
      email: "user@example.com",
    });

    expect(response.status).toBe(400);
  });
});
