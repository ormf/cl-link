#include <ableton/Link.hpp>
#include <clcxx/clcxx.hpp>
#include "clcxx/clcxx_config.hpp"

CLCXX_PACKAGE LINK_CLCXX (clcxx::Package& pack)
{
  using namespace ableton;

  using Clock = Link::Clock;
  using SessionState = Link::SessionState;
  using micros = std::chrono::microseconds;

  
  pack.defclass<Link::Clock, false>("Clock")
    .defmethod("micros", &Clock::micros)
    //    .constructor<>()
    ;
  
  pack.defclass<Link::SessionState, false>("SessionState")
    .defmethod("tempo", &SessionState::tempo)
    // .defmethod("setTempo", [](SessionState &sessionState, const double tempo, const uint64_t time)
    // { sessionState.setTempo(tempo, std::chrono::microseconds(time)); })


    //   .defmethod("beatAtTime", [](SessionState &sessionState, uint64_t time, double quantum)
  //   { return sessionState.beatAtTime(micros(time), quantum); })
  //   .defmethod("phaseAtTime",  [](SessionState &sessionState, uint64_t time, double quantum)
  //   { return sessionState.phaseAtTime(micros(time), quantum); })
  //   .defmethod("timeAtBeat", [](SessionState &sessionState, double beat, double quantum)
  //          { return sessionState.timeAtBeat(beat, quantum).count(); })
  //   .defmethod("requestBeatAtTime", [](SessionState &sessionState, double beat, uint64_t time, double quantum)
  //          { sessionState.requestBeatAtTime(beat, micros(time), quantum); })
  //   .defmethod("isPlaying", &SessionState::isPlaying)
  //   .defmethod("setIsPlaying",  [](SessionState &sessionState, const bool isPlaying, const uint64_t time)
  //   { sessionState.setIsPlaying(isPlaying, micros(time)); })
    //    .constructor<>()
    ;
  // 
  pack.defclass<Link, false>("Link")
  // //   //    .defmethod(init)
     .defmethod("isEnabled", &Link::isEnabled)
     .defmethod("enable", &Link::enable)
  //    .defmethod("numPeers", &Link::numPeers)
  //    .defmethod("clock", &Link::clock)
  //    .defmethod("captureSessionState", &Link::captureAppSessionState)
  //    .defmethod("commitSessionState", &Link::commitAppSessionState)
  //    .defmethod("isStartStopSyncEnabled", &Link::isStartStopSyncEnabled)
  //    .defmethod("enablestartStopSync", &Link::enableStartStopSync)
  //   // .defmethod("setNumPeersCallback", [](Link &link, const std::function<void(std::size_t)> &callback)
  //   //        { link.setNumPeersCallback(callback); })
  //   // .defmethod("setTempoCallback", [](Link &link, const std::function<void(double)> &callback)
  //   //        { link.setTempoCallback(callback); })
  //   // .defmethod("setStartStopCallback", [](Link &link, const std::function<void(bool)> &callback)
  //   //        { link.setStartStopCallback(callback); })
    .constructor<double>()
    ;
}
