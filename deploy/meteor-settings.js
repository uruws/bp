const fs = require("fs");
const path = "/run/meteor/app-settings.json";
try {
	const data = fs.readFileSync(path, "utf8");
	console.log(data);
} catch (err) {
	console.error(err);
}
