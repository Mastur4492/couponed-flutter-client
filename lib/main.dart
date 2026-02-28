import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/coupon.dart';
import 'services/api_service.dart';
import 'providers/coupon_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CouponProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Coupon>> coupons;

  @override
  void initState() {
    super.initState();
    coupons = ApiService.fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CouponProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Couponed",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0B0F1A),
              Color(0xFF111827),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Coupon>>(
          future: coupons,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3B82F6),
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Failed to load coupons",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final data = snapshot.data!;

            return ListView.builder(
              padding:
                  const EdgeInsets.fromLTRB(16, 100, 16, 20),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final coupon = data[index];
                final isClaimed =
                    provider.isClaimed(coupon.id);

                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C22),
                    borderRadius:
                        BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 15,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 130,
                        decoration:
                            const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF3B82F6),
                              Color(0xFF6366F1),
                            ],
                          ),
                          borderRadius:
                              BorderRadius.only(
                            topLeft:
                                Radius.circular(20),
                            bottomLeft:
                                Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            coupon.title
                                .substring(0, 4)
                                .toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                coupon.title,
                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Colors.white,
                                ),
                              ),
                              const SizedBox(
                                  height: 6),
                              Text(
                                coupon.description,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white70,
                                ),
                              ),
                              const SizedBox(
                                  height: 16),
                              Align(
                                alignment: Alignment
                                    .centerRight,
                                child:
                                    ElevatedButton(
                                  style:
                                      ElevatedButton
                                          .styleFrom(
                                    backgroundColor:
                                        isClaimed
                                            ? Colors
                                                .grey
                                            : const Color(
                                                0xFF3B82F6),
                                  ),
                                  onPressed:
                                      isClaimed
                                          ? null
                                          : () {
                                              provider
                                                  .claimCoupon(
                                                      coupon
                                                          .id);

                                              Navigator
                                                  .push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) =>
                                                          ClaimScreen(
                                                    title:
                                                        coupon.title,
                                                  ),
                                                ),
                                              );
                                            },
                                  child: Text(
                                    isClaimed
                                        ? "Claimed"
                                        : "Claim",
                                    style:
                                        const TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ClaimScreen extends StatelessWidget {
  final String title;

  const ClaimScreen(
      {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0B0F1A),
      body: Center(
        child: Container(
          padding:
              const EdgeInsets.all(30),
          margin:
              const EdgeInsets.symmetric(
                  horizontal: 40),
          decoration: BoxDecoration(
            color:
                const Color(0xFF1C1C22),
            borderRadius:
                BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.verified_rounded,
                size: 90,
                color:
                    Color(0xFF3B82F6),
              ),
              const SizedBox(height: 20),
              const Text(
                "Coupon Applied Successfully",
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style:
                    const TextStyle(
                  color:
                      Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style:
                    ElevatedButton
                        .styleFrom(
                  backgroundColor:
                      const Color(
                          0xFF3B82F6),
                ),
                onPressed: () =>
                    Navigator.pop(
                        context),
                child:
                    const Text("Back"),
              )
            ],
          ),
        ),
      ),
    );
  }
}