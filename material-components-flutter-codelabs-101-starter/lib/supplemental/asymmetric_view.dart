import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/product.dart';

class AsymmetricView extends StatelessWidget {
  final List<Product> products;

  const AsymmetricView({Key? key, required this.products}) : super(key: key);

  List<DataColumn> _buildColumns(BuildContext context) {
    if (products.isEmpty) {
      return const <DataColumn>[];
    }

    /// This will return a list of columns. It will oscillate between the two
    /// kinds of columns. Even cases of the index (0, 2, 4, etc) will be
    /// TwoProductCardColumn and the odd cases will be OneProductCardColumn.
    return List.generate((products.length / 3).ceil(), (int index) {
      double width = .59 * MediaQuery.of(context).size.width;
      if (index % 2 == 0) {
        width += 32.0;
      }
      // TODO: Make a generic Column class (104)
      return DataColumn(
        label: SizedBox(
          width: width,
          child: _buildColumn(context, index),
        ),
      );
    }).toList();
  }

  Widget _buildColumn(BuildContext context, int index) {
    if (index % 2 != 0) {
      return OneProductCardColumn(
        product: products[index],
      );
    }

    return TwoProductCardColumn(
      bottom: products[index],
      top: products.length - 1 >= index + 1 ? products[index + 1] : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _buildColumns(context),
        rows: const <DataRow>[],
        dataRowHeight: 500.0,
        headingRowHeight: 500.0,
        columnSpacing: 32.0,
      ),
    );
  }
}

class OneProductCardColumn extends StatelessWidget {
  const OneProductCardColumn({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      reverse: true,
      children: <Widget>[
        const SizedBox(
          height: 40.0,
        ),
        ProductCard(
          product: product,
        ),
      ],
    );
  }
}

class TwoProductCardColumn extends StatelessWidget {
  const TwoProductCardColumn({
    Key? key,
    required this.bottom,
    this.top,
  }) : super(key: key);

  final Product bottom;
  final Product? top;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      const double spacerHeight = 44.0;

      double heightOfCards = (constraints.biggest.height - spacerHeight) / 2.0;
      double heightOfImages = heightOfCards - ProductCard.kTextBoxHeight;
      double imageAspectRatio = heightOfImages >= 0.0
          ? constraints.biggest.width / heightOfImages
          : 49.0 / 33.0;

      return ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: spacerHeight),
            child: top != null
                ? ProductCard(
                    product: top!,
                  )
                : SizedBox(
                    height: heightOfCards,
                  ),
          ),
          ProductCard(
            product: bottom,
          ),
        ],
      );
    });
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  static const double kTextBoxHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          product.assetName,
          package: product.assetPackage,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: kTextBoxHeight,
          width: 144.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.name,
                style: theme.textTheme.titleLarge,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 8.0),
              Text(
                formatter.format(product.price),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
