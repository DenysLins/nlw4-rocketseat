import { Router } from "express";
import { UserController } from "./controllers/UserController";

const router = Router();

const userController = new UserController();

const prefix = "/api";

router.post(`${prefix}/users`, userController.create);

export { router };
