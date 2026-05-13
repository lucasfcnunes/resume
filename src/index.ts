import { library, dom } from "@fortawesome/fontawesome-svg-core";
import {
  faArchway,
  faBrazilianRealSign,
  faCodeBranch,
  faEnvelope,
  faPhone,
  faPersonHiking,
  faRocket,
  faGlobe,
  faSkiingNordic,
  faCamera,
  faBeer,
  faSuitcase,
  faNetworkWired,
  faFlagUsa,
} from "@fortawesome/free-solid-svg-icons";
import {
  faGithub,
  faTwitter,
  faWhatsapp,
  faTelegram,
  faLinkedin,
  faXTwitter,
} from "@fortawesome/free-brands-svg-icons";

library.add(
  faArchway,
  faBrazilianRealSign,
  faCodeBranch,
  faEnvelope,
  faPersonHiking,
  faRocket,
  faPhone,
  faGlobe,
  faSkiingNordic,
  faCamera,
  faBeer,
  faSuitcase,
  faNetworkWired,
  faFlagUsa,
  faGithub,
  faTwitter,
  faWhatsapp,
  faTelegram,
  faLinkedin,
  faXTwitter,
);
// This will look continously to convert i-fa to svg
dom.watch();

import resume from "./resume.yaml";
import { Elm } from "./Main.elm";

document.addEventListener("DOMContentLoaded", function () {
  let app = Elm.Main.init({
    flags: resume,
    node: document.getElementById("app"),
  });
});
