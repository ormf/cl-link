#include <ableton/Link.hpp>
#include <clcxx/clcxx.hpp>
#include "clcxx/clcxx_config.hpp"

CLCXX_PACKAGE LINK_CLCXX (clcxx::Package& pack)
{
  using namespace ableton;

  using Clock = Link::Clock;
  using SessionState = Link::SessionState;
  using micros = std::chrono::microseconds;

  
 // pack.defclass<Link::Clock, false>("Clock")
 //   .defmethod("micros", F_PTR([](Clock &clock) {
 //                   return clock.micros().count();
 //                 }))
 //   ;
  
  pack.defclass<Link::SessionState, false>("SessionState")
    .defmethod("tempo", F_PTR(&SessionState::tempo))
    .defmethod("setTempo", F_PTR([](SessionState &sessionState, const double tempo, const uint64_t time)
    { sessionState.setTempo(tempo, std::chrono::microseconds(time)); }))
    .defmethod("beatAtTime", F_PTR([](SessionState &sessionState, uint64_t time, double quantum)
    { return sessionState.beatAtTime(micros(time), quantum); }))
    .defmethod("phaseAtTime", F_PTR([](SessionState &sessionState, uint64_t time, double quantum)
    { return sessionState.phaseAtTime(micros(time), quantum); }))
    .defmethod("timeAtBeat", F_PTR([](SessionState &sessionState, double beat, double quantum)
    { return sessionState.timeAtBeat(beat, quantum).count(); }))
    .defmethod("requestBeatAtTime", F_PTR([](SessionState &sessionState, double beat, uint64_t time, double quantum)
    { sessionState.requestBeatAtTime(beat, micros(time), quantum); }))
    .defmethod("isPlaying", F_PTR(&SessionState::isPlaying))
    .defmethod("setIsPlaying", F_PTR([](SessionState &sessionState, const bool isPlaying, const uint64_t time)
    { sessionState.setIsPlaying(isPlaying, micros(time)); }))
    //       .constructor<>()
    ;
  
  pack.defclass<Link, false>("Link")
    // .defmethod(init)
    .defmethod("isEnabled", F_PTR(&Link::isEnabled))
    .defmethod("enable", F_PTR(&Link::enable))
    .defmethod("numPeers", F_PTR(&Link::numPeers))
    .defmethod("micros", F_PTR([](Link &link) {
                   return link.clock().micros().count();
                 }))
    .defmethod("captureSessionState", F_PTR(&Link::captureAppSessionState))
    .defmethod("commitSessionState", F_PTR(&Link::commitAppSessionState))
    .defmethod("isStartStopSyncEnabled", F_PTR(&Link::isStartStopSyncEnabled))
    .defmethod("enablestartStopSync", F_PTR(&Link::enableStartStopSync))
    .defmethod("setNumPeersCallback",
               F_PTR([](Link &link, const std::function<void(std::size_t)> &callback)
    { link.setNumPeersCallback(callback); }))
    .defmethod("setTempoCallback", F_PTR([](Link &link, const std::function<void(double)> &callback)
    { link.setTempoCallback(callback); }))
    .defmethod("setStartStopCallback", F_PTR([](Link &link, const std::function<void(bool)> &callback)
    { link.setStartStopCallback(callback); }))
    .constructor<double>("make-AbletonLink")
    ;
}
