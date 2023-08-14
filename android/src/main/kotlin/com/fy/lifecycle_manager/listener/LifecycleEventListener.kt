package com.fy.lifecycle_manager.listener

import com.fy.lifecycle_manager.model.Lifecycle

interface LifecycleEventListener {

    fun onNewLifecycleEvent(lifecycle: Lifecycle);

}