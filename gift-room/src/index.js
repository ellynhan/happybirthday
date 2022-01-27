import { Controller } from "./controller/homeController.js";
import Home from "./view/home.js";

// localStorage.clear();
let controller = new Controller();
let home = new Home(controller);

