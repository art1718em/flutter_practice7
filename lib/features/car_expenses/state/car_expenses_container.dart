import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/expense_model.dart';
import '../screens/car_expenses_screen.dart';

class CarExpensesContainer extends StatefulWidget {
  const CarExpensesContainer({super.key});

  @override
  State<CarExpensesContainer> createState() => _CarExpensesContainerState();
}

class _CarExpensesContainerState extends State<CarExpensesContainer> {
  final List<ExpenseModel> _expenses = [];
  final _uuid = const Uuid();

  ExpenseModel? _recentlyRemovedExpense;
  int? _recentlyRemovedExpenseIndex;

  double get _totalAmount {
    return _expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  void _saveExpense(String title, double amount) {
    final newExpense = ExpenseModel(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _removeExpense(String id) {
    final expenseIndex = _expenses.indexWhere((expense) => expense.id == id);
    if (expenseIndex < 0) {
      return;
    }

    setState(() {
      _recentlyRemovedExpenseIndex = expenseIndex;
      _recentlyRemovedExpense = _expenses.removeAt(expenseIndex);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Расход удален'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'ОТМЕНИТЬ',
            onPressed: _undoRemove,
          ),
        ),
      );
    });
  }

  void _undoRemove() {
    if (_recentlyRemovedExpense != null && _recentlyRemovedExpenseIndex != null) {
      setState(() {
        _expenses.insert(
            _recentlyRemovedExpenseIndex!, _recentlyRemovedExpense!);
        _recentlyRemovedExpense = null;
        _recentlyRemovedExpenseIndex = null;
      });
    }
  }

  void _navigateToAddExpense() async {
    final result = await context.push<Map<String, dynamic>?>('/expenses/add');
    if (result != null && result.containsKey('title') && result.containsKey('amount')) {
      _saveExpense(result['title'] as String, result['amount'] as double);
    }
  }

  void _navigateToInfo() {
    context.pushReplacement('/info');
  }

  void _navigateToHistory() {
    context.pushReplacement('/history');
  }

  @override
  Widget build(BuildContext context) {
    return CarExpensesScreen(
      expenses: _expenses,
      totalAmount: _totalAmount,
      onAddExpense: _navigateToAddExpense,
      onRemove: _removeExpense,
      onNavigateToInfo: _navigateToInfo,
      onNavigateToHistory: _navigateToHistory,
    );
  }
}
