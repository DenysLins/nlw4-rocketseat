import { Router } from "express";
import { UsersController } from "./controllers/UsersController";

const router = Router();

const usersController = new UsersController();

const prefix = "/api";

router.post(`${prefix}/users`, usersController.create);

export { router };
