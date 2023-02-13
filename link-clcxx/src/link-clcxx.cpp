#include <ableton/Link.hpp>
#include "AudioPlatform.hpp"
//#include "AudioPlatform_Jack.hpp"
#include "AudioEngine.hpp"
#include <clcxx/clcxx.hpp>
#include "clcxx/clcxx_config.hpp"

// typedef ableton::LINK* mypt;

CLCXX_PACKAGE LINK_CLCXX (clcxx::Package& pack)
{
  using namespace ableton;

  using namespace ableton::linkaudio;

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
    .defmethod("set-tempo", F_PTR([](SessionState &sessionState, const double tempo, const uint64_t time)
    { sessionState.setTempo(tempo, std::chrono::microseconds(time)); }))
    .defmethod("beat-at-time", F_PTR([](SessionState &sessionState, uint64_t time, double quantum)
    { return sessionState.beatAtTime(micros(time), quantum); }))
    .defmethod("phase-at-time", F_PTR([](SessionState &sessionState, uint64_t time, double quantum)
    { return sessionState.phaseAtTime(micros(time), quantum); }))
    .defmethod("time-at-beat", F_PTR([](SessionState &sessionState, double beat, double quantum)
    { return sessionState.timeAtBeat(beat, quantum).count(); }))
    .defmethod("request-beat-at-time", F_PTR([](SessionState &sessionState, double beat, uint64_t time, double quantum)
    { sessionState.requestBeatAtTime(beat, micros(time), quantum); }))
    .defmethod("is-playing", F_PTR(&SessionState::isPlaying))
    .defmethod("set-is-playing", F_PTR([](SessionState &sessionState, const bool isPlaying, const uint64_t time)
    { sessionState.setIsPlaying(isPlaying, micros(time)); }))
    .constructor<link::ApiState, bool>()
    ;
  
  pack.defclass<Link, false>("Link")
    // .defmethod(init)
    .defmethod("is-enabled", F_PTR(&Link::isEnabled))
    .defmethod("enable", F_PTR([](Link &link, bool bEnable)
    { link.enable(bEnable); }))
    .defmethod("enable-start-stop-sync", F_PTR([](Link &link, bool bEnable)
    { link.enableStartStopSync(bEnable); }))
    //    .defmethod("num-peers", F_PTR(&Link::numPeers))
    .defmethod("num-peers", F_PTR([](Link &link)
    { return link.numPeers(); }))
    .defmethod("micros", F_PTR([](Link &link) {
                   return link.clock().micros().count();
                 }))
    .defmethod("capture-session-state", F_PTR(&Link::captureAppSessionState))
    .defmethod("commit-session-state", F_PTR(&Link::commitAppSessionState))
    .defmethod("is-start-stop-sync-enabled", F_PTR(&Link::isStartStopSyncEnabled))
    .defmethod("set-num-peers-callback",
               F_PTR([](Link &link, const std::function<void(std::size_t)> &callback)
    { link.setNumPeersCallback(callback); }))
    .defmethod("set-tempo-callback", F_PTR([](Link &link, const std::function<void(double)> &callback)
    { link.setTempoCallback(callback); }))
    .defmethod("set-start-stop-callback", F_PTR([](Link &link, const std::function<void(bool)> &callback)
    { link.setStartStopCallback(callback); }))
    .constructor<double>("make-ableton-link")
    ;

}
