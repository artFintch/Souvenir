# Souvenir

![Animations](https://media.giphy.com/media/xThtabA1tDfnP9K1Jm/giphy.gif)
![Stripe](https://media.giphy.com/media/xUOwG5LxksHbKgQsQo/giphy.gif)
![Pay](https://media.giphy.com/media/3o7WIq46HWgJ5bdMT6/giphy.gif)

Тестовое задание. План:
- [x] Главный экран, анимация;
- [x] Меню выбора карты;
- [ ] Форма создания карты, валиадация;
  - [x] Стандартный UI Stripe;
  - [ ] Кастомный UI.
- [x] Использование Stripe ([Пример backend'а на Ruby](https://github.com/artFintch/example-ios-backend));
- [ ] Тесты, рефакторинг.

Для использования Stripe необходимо реализовать расширение:
```swift
extension AppConfig {
    var stripePublishableKey: String {
        return "your_stripe_publishable_key"
    }
}
```
