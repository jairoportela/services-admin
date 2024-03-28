import 'package:flutter/material.dart';
import 'package:services_admin/src/common/widgets/app_texts.dart';
import 'package:services_admin/src/services/data/models/routes_data.dart';
import 'package:services_admin/src/services/data/models/service_filter.dart';
import 'package:services_admin/src/users/data/repository/user_repository.dart';
import 'package:services_admin/src/utils/extensions/datetime_extension.dart';

class SearchFilterModal extends StatefulWidget {
  const SearchFilterModal({super.key, required this.initialFilters});
  final ServiceFilter initialFilters;

  @override
  State<SearchFilterModal> createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  late ServiceFilter _filters;

  @override
  void initState() {
    _filters = widget.initialFilters;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(15).copyWith(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              'Filtros',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            DriverFilter(
              initialValue: widget.initialFilters.driverId,
              onChanged: (value) {
                setState(() {
                  _filters = _filters.copyWith(
                    driverId: () => value,
                  );
                });
              },
            ),
            const SizedBox(height: 10),
            RouteFilter(
              initialValue: widget.initialFilters.route,
              onChanged: (value) {
                setState(() {
                  _filters = _filters.copyWith(
                    route: () => value,
                  );
                });
              },
            ),
            const SizedBox(height: 10),
            DateRangeFilter(
              start: widget.initialFilters.initialDate,
              end: widget.initialFilters.finalDate,
              onChange: (range) {
                setState(() {
                  _filters = _filters.copyWith(
                    initialDate: () => range?.start,
                    finalDate: () => range?.end,
                  );
                });
              },
            ),
            const SizedBox(height: 10),
            FilterButton(
              initialFilter: widget.initialFilters,
              modifyFilter: _filters,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.modifyFilter,
    required this.initialFilter,
  });
  final ServiceFilter modifyFilter;
  final ServiceFilter initialFilter;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        Navigator.pop(
            context, initialFilter != modifyFilter ? modifyFilter : null);
      },
      child: const Text('Filtrar'),
    );
  }
}

class DateRangeFilter extends StatefulWidget {
  const DateRangeFilter({
    super.key,
    required this.start,
    required this.end,
    required this.onChange,
  });
  final DateTime? start;
  final DateTime? end;
  final Function(DateTimeRange? range) onChange;

  @override
  State<DateRangeFilter> createState() => _DateRangeFilterState();
}

class _DateRangeFilterState extends State<DateRangeFilter> {
  final TextEditingController _textController = TextEditingController();
  DateTimeRange? _range;

  String getText(DateTimeRange range) {
    return '${range.start.toDate()} <-> ${range.end.toDate()}';
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      initialDateRange: _range,
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      setState(() {
        _range = picked;
        _textController.text = getText(picked);
      });
      widget.onChange(picked);
    }
  }

  @override
  void initState() {
    if (widget.start != null && widget.end != null) {
      _range = DateTimeRange(start: widget.start!, end: widget.end!);
      _textController.text = getText(_range!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Rango de fechas',
      child: TextField(
        onTap: _selectDateRange,
        readOnly: true,
        controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: _range != null
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _range = null;
                      _textController.text = '';
                    });
                    widget.onChange(null);
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class RouteFilter extends StatefulWidget {
  const RouteFilter({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  final String? initialValue;
  final void Function(String? value)? onChanged;

  @override
  State<RouteFilter> createState() => _RouteFilterState();
}

class _RouteFilterState extends State<RouteFilter> {
  String? initialValue;

  @override
  void initState() {
    initialValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Ruta',
      child: DropdownButtonFormField(
        value: initialValue,
        onChanged: (value) {
          setState(() {
            initialValue = value;
          });
          widget.onChanged?.call(value);
        },
        items: routesData,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: initialValue != null
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      initialValue = null;
                    });
                    widget.onChanged?.call(null);
                  },
                )
              : null,
        ),
      ),
    );
  }
}

class DriverFilter extends StatefulWidget {
  const DriverFilter(
      {super.key, required this.initialValue, required this.onChanged});
  final String? initialValue;
  final void Function(String? value)? onChanged;

  @override
  State<DriverFilter> createState() => _DriverFilterState();
}

class _DriverFilterState extends State<DriverFilter> {
  String? initialValue;

  @override
  void initState() {
    initialValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      title: 'Conductor',
      child: DropdownButtonFormField(
        value: initialValue,
        onChanged: (value) {
          setState(() {
            initialValue = value;
          });
          widget.onChanged?.call(value);
        },
        items: UsersRepositoryImplementation()
            .getDrivers()
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(
                    e.name,
                  ),
                ))
            .toList(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: initialValue != null
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      initialValue = null;
                    });
                    widget.onChanged?.call(null);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
