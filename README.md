# Fahim Montasir Opi's Portfolio

This is a Flutter web portfolio application showcasing Fahim Montasir Opi's skills, projects, and contact information.

## Hosting on Vercel

This portfolio is configured for deployment on Vercel. Follow these steps to deploy:

1. Create a Vercel account at [vercel.com](https://vercel.com) if you don't have one
2. Install the Vercel CLI: `npm i -g vercel`
3. Navigate to the project directory
4. Run `vercel login` and follow the authentication process
5. Run `vercel` and follow the on-screen instructions
6. For subsequent deployments, run `vercel --prod`

## Local Development

To run this application locally:

1. Make sure you have Flutter installed
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run -d chrome` to launch in Chrome

## Building

To build the web version:

```bash
flutter build web --release
```

The build output will be in the `build/web` directory.
