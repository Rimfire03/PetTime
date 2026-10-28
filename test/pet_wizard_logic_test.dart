import 'package:flutter_test/flutter_test.dart';
import 'package:pettime/care_catalog.dart';
import 'package:pettime/screens/pet_wizard_screen.dart';

void main() {
  test('name is required to leave the first step', () {
    final a = WizardAnswers(name: '  ');
    expect(a.canGoNext(WizardStep.name), isFalse);
    a.name = 'Rex';
    expect(a.canGoNext(WizardStep.name), isTrue);
  });

  test('weight accepts comma and dot, rejects junk', () {
    expect(parseWeight('4,2'), 4.2);
    expect(parseWeight(' 4.2 '), 4.2);
    expect(parseWeight('abc'), isNull);
    expect(parseWeight('0'), isNull);
    final a = WizardAnswers(weight: 'abc');
    expect(a.canGoNext(WizardStep.weight), isFalse);
    a.weight = '';
    expect(a.canGoNext(WizardStep.weight), isTrue);
  });

  test('weight row only when a weight is given', () {
    final today = DateTime(2026, 1, 1);
    expect(WizardAnswers().toWeight(1, today), isNull);
    expect(WizardAnswers(weight: '4,2').toWeight(1, today)!.kg.value, 4.2);
  });

  test('vaccine row needs both vaccine and date, nextDue uses repeat rhythm', () {
    final rabies = careCatalog['dog']!.values.first.firstWhere((s) => s.fr == 'Rage');
    expect(WizardAnswers(vaccine: rabies).toVaccine(1, 'en'), isNull);
    expect(WizardAnswers(vaccineDate: DateTime(2026, 1, 31)).toVaccine(1, 'en'), isNull);
    final r = WizardAnswers(vaccine: rabies, vaccineDate: DateTime(2026, 1, 31)).toVaccine(1, 'en')!;
    expect(r.product.value, 'Rabies');
    expect(r.nextDue.value, addMonths(DateTime(2026, 1, 31), 12));
    expect(r.remindDaysBefore.value, 7);
  });

  test('vaccine step is dropped for species without vaccines', () {
    expect(wizardSteps('dog'), contains(WizardStep.vaccine));
    expect(wizardSteps('other'), isNot(contains(WizardStep.vaccine)));
  });

  test('vet phone step only when a vet name was given', () {
    expect(wizardSteps('dog'), contains(WizardStep.vetPhone));
    expect(wizardSteps('dog', hasVet: false), isNot(contains(WizardStep.vetPhone)));
    expect(WizardAnswers(vetPhone: '0102030405').toPet().vetPhone.value, isNull);
    expect(WizardAnswers(vet: 'Dr X', vetPhone: '0102030405').toPet().vetPhone.value, '0102030405');
  });

  test('"other" vaccine uses the typed name and no next due date', () {
    final d = DateTime(2026, 1, 31);
    expect(WizardAnswers(vaccine: otherVaccine, vaccineDate: d).toVaccine(1, 'fr'), isNull);
    final r = WizardAnswers(vaccine: otherVaccine, vaccineOther: ' Parvo ', vaccineDate: d).toVaccine(1, 'fr')!;
    expect(r.product.value, 'Parvo');
    expect(r.nextDue.value, isNull);
  });
}
