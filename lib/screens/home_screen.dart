import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_wheather_app/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/weather_detail_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //天気アイコン
  Widget getWeathericon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case >= 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double contentWidth;

    if (screenWidth < 600) {
      contentWidth = MediaQuery.of(context).size.width * 0.9;
    } else if (screenWidth < 1200) {
      contentWidth = MediaQuery.of(context).size.width * 0.8;
    } else {
      contentWidth = MediaQuery.of(context).size.width * 0.5;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0 * kToolbarHeight, 20, 40),
          child: SizedBox(
            width: contentWidth,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(2, -0.3),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-2, -0.3),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.8),
                  child: Container(
                    width: 600,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFAB40),
                    ),
                  ),
                ),
                //ぼやかす
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccess) {
                      return ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.weather.areaName!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: getWeathericon(
                                  state.weather.weatherConditionCode!,
                                ),
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      '${state.weather.temperature!.celsius!.round()}℃',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                      ),
                                    ),
                                    Text(
                                      state.weather.weatherMain!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('M月d日 / EEEE', 'ja_JP')
                                          .add_jm()
                                          .format(state.weather.date!),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        WeatherDetailInfo(
                                          image: '11.png',
                                          title: '日の出',
                                          content: DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                        ),
                                        WeatherDetailInfo(
                                          image: '12.png',
                                          title: '日の入り',
                                          content: DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        WeatherDetailInfo(
                                          image: '13.png',
                                          title: '最高気温',
                                          content:
                                              '${state.weather.tempMin!.celsius!.round()}℃',
                                        ),
                                        WeatherDetailInfo(
                                          image: '14.png',
                                          title: '最低気温',
                                          content:
                                              '${state.weather.tempMin!.celsius!.round()}℃',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
