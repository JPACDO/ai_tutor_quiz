# Ai Tutor Quiz

App for learning and queries, with the ability to generate questions according to the topic. It is based on Gemini, Google's artificial intelligence

## Getting Started

https://github.com/user-attachments/assets/7158e2b2-f51d-4e4d-bca4-46a3274a5f80


[![](https://markdown-videos.deta.dev/youtube/KwL4oAkkwfg)](https://youtu.be/KwL4oAkkwfg)

## Notes

Create an .env file in the root folder, insert into it GEMINI_KEY="your_key", then run: "dart run build_runner build". 
It is also necessary to configure firebase (flutterfire configure), since it creates the file firebase_options.dart,
otherwise comment the lines related to firebase in the main and in lib/config/routes/app_router.dart initialLocation change '/upgrade' to '/'.
