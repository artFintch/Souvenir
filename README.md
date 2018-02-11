# Souvenir
Тестовое задание. План:
- [x] Главный экран, анимация;
- [x] Меню выбора карты;
- [ ] Форма создания карты, валиадация;
  - [x] Стандартный UI Stripe;
  - [ ] Кастомный UI.
- [x] Использование Stripe;
- [ ] Тесты, рефакторинг.

Для использования Stipe необходимо реализовать расширение:
```swift
extension AppConfig {
    var stripePublishableKey: String {
        return "your_stripe_publishable_key"
    }
}
```
