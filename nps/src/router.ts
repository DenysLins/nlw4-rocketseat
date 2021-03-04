import { Router } from "express";
import { SurveysController } from "./controllers/SurveysController";
import { UsersController } from "./controllers/UsersController";

const router = Router();

const usersController = new UsersController();
const surveysController = new SurveysController();

const prefix = "/api";

router.post(`${prefix}/users`, usersController.create);

router.get(`${prefix}/surveys`, surveysController.show);
router.post(`${prefix}/surveys`, surveysController.create);

export { router };
