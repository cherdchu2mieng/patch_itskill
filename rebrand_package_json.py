import json
import sys
import os

target_path = sys.argv[1]
package_json_path = os.path.join(target_path, "package.json")

with open(package_json_path, "r") as f:
    data = json.load(f)

# Rebranding
data["name"] = "it-skill-cli"
data["version"] = "1.0.0"
data["description"] = "IT-Skill CLI — Enterprise Governance and Skill Management for itinfosv"
data["bin"] = {
    "it-skill": "./src/cli/index.ts"
}
data["author"] = "itinfosv"
data["repository"] = {
    "type": "git",
    "url": "git+https://github.com/itinfosv/it-skill-cli.git"
}
data["bugs"] = {
    "url": "https://github.com/itinfosv/it-skill-cli/issues"
}
data["homepage"] = "https://github.com/itinfosv/it-skill-cli#readme"
data["skillTag"] = "[itinfosv]"

# Manifest Tag
data["it-skill-patch"] = "rebrand_package_json@v1.0"

with open(package_json_path, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")

print("✅ package.json rebranded successfully via structured JSON update.")
